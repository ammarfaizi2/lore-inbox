Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757574AbWKXCqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbWKXCqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 21:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757575AbWKXCqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 21:46:25 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:41146 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1757574AbWKXCqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 21:46:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kOoqeDjEEVDywLFVIUBwq3saMbuDgavsq3uLj6ZHO9IhjK46drvBcirv/3/EJQY+xW8n2qsaVPMX2A15WTlipT+9trg3XQvK6QwD4x9BnXwhvuwfKzYMA6djmf4ONbgCITk4s3esxZQN4rWN7TK7YzapM1QuXx3vUSDXwbH9K6o=
Message-ID: <f55850a70611231846p2109188by84283d0b64fc8853@mail.gmail.com>
Date: Fri, 24 Nov 2006 10:46:23 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: filp_open fail with ENOTDIR in kernel 2.6.16
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm porting some kernel module codes from kernel 2.4 to 2.6. The codes
used to work well under 2.4 kernel. In 2.6 environment, the problem is
filp_open("/root/test.txt",O_RDONLY,0) always return -20 (ENOTDIR).
But the regular file "/root/test.txt" does exist. What's wrong?
