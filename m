Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVDLTC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVDLTC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVDLTBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:01:18 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:7962 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262492AbVDLSHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:07:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=t6lYBpsDnFzw0+orlSzxTRs1F7TCqhbCI2u/SL2I4OMPEs4Cn8V39v9utU8koWfQ0Azgb+zGgDR1EXJ2t+s05TJzIjsb1P9gFJ6H8mRJHzUvAngQApzC3p6lp6xySjTFzYPLk6GASbBIKS5sPZvtAzXTDHvdiiuk6/LCnvqczaE=
Message-ID: <425C0E60.7000708@gmail.com>
Date: Tue, 12 Apr 2005 14:07:28 -0400
From: Bastian Beutner <tevid411@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ATI Radeon 9000 M9 mobitility troubles on linux 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmesg for linux 2.4

agpgart: Detected an Intel(R) 845G, but could not find the secondary 
device. Assuming a non-integrated video card

dmesg for linux 2.6

agpgart: Detected an Intel(R) 845G

on 2.6 x will start with vesa but due to this being a laptop i cannot do 
1400 x 1050

radeon and/or fglrx drivers will not start X on 2.6 but will start X on 2.4

lspci shows the card as being there under 2.6 and 2.4 as follows

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 
Lf [FireGL 9000] (rev 01)

tried setting BUSID in X config but to no avail X will not detect the card

any ideas?

please CC me the answers

tevid

Linux scion 2.4.28-gentoo-r7 #6 Thu Mar 31 03:37:29 EST 2005 i686 
Intel(R) Pentium(R) 4 CPU 2.66GHz GenuineIntel GNU/Linux


