Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbVEHWmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbVEHWmw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 18:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbVEHWmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 18:42:52 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:3850 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262997AbVEHWmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 18:42:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HNHnowOyARp8/FbvrFnzvYFLucIcXA9BSZMXRrLa3Y/pLhWizJiKWAfuv7JmPeH3MpOauk16IqS3VS0rqTFqnuerfGFgduHyCFaKOC3VZVj8tmrqvHes2ompYDEN1Pob4uhTiRDbtUJqdEnOEZG33GdHhEjVlND+TujE+QEyHno=
Message-ID: <427EA3D8.1060001@gmail.com>
Date: Mon, 09 May 2005 01:42:16 +0200
From: Eugene San <eugenesan@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Davicom 9102AF (dmfe) / Alladin V IDE(ali15xx) on sparc64(v100/Netra-x)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probem with Davicom91xx ethernet NIC on sparc64(v100/Netra-x) is well 
known (google ::dmfe+sparc).
The problem is that specific driver (dmfe)  can be loaded but once used 
couses errors on PCI/sabre and at the end couses Kernel Panic.
Some pepole advice using (tulip) wich loads but fails to work normaly: 
it works at ~10Mbps in 10BaseT4 mode while all other modes brings
huge amount of carierr/TX errors and VERY low throuput(sometimes less 
then 50Kbps) and after some time at mid/high load driver fails
with some kind of TX errors.
Another problem is with DMA on Alladin V wich used on thoses machines.
Usualy kernel unable to boot if strated without ide=nodma. If DMA 
set-on  after boot is often couses data loses.

Bothe problems well known for a long time but somehow not treated till now.
The problems exists in kernels since 2.4.17 up to latest 2.6.11 ( all 
versions in that range tested by me :-( )

I wonder if there anything that can be done to make those sparc64 
machines usable with linux.

Thanks ahead.
