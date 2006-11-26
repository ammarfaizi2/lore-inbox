Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754451AbWKZXUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbWKZXUU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbWKZXUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:20:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:18084 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1754451AbWKZXUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:20:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=VBgOH6F0I3Yj/AIOGcE1OPnU/DQcIoCL2iI7W92aSOwMPQpIBvBoCXni4xmFRdQU9jWXmSfdITX78rb3NP7eisyDJzrHfmVKvNRb9FPU2HdVChDk0uv7snOwmUJqzi2mFTmJ6Njuv7CJwqpGWdrIxU+2h0lHVFQLGI6/21zM1JU=
Message-ID: <86802c440611261520h130340ecq802356568fccfe83@mail.gmail.com>
Date: Sun, 26 Nov 2006 15:20:16 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 0/3] madt/dsdt and mptable
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: bcad2f512c4ebdfe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while i was testing LinuxBIOS with ACPI support but left dsdt out,
found if MADT is there, the MPTABLE will be skipped. and device can
not use irq routing in mptable.

Please check it

YH
