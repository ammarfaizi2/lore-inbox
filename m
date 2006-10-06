Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWJFOhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWJFOhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWJFOhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:37:24 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14603 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932371AbWJFOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:37:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P1+m9DAXr0TMIbg65hOcFNQljhmUEiFMz6+ySyNWtnxCm84APMu8kDagAnR+Jn67FtuTMI6a5m3TWlvqII9Lao1ogfNa1+UUFoHKBlswm60Fd3jBofurq3kpkc4jxIgvQipPWYq02aOdMyNBXTKGsrHthhjufkvaFy1CP541dmw=
Message-ID: <55c223960610060737p1a5fda6bl95547accc7d96468@mail.gmail.com>
Date: Fri, 6 Oct 2006 15:37:22 +0100
From: "Alex Owen" <r.alex.owen@gmail.com>
To: "Ayaz Abdulla" <AAbdulla@nvidia.com>
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B0189CAB06@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061005193113.GE18408@tuxdriver.com>
	 <DBFABB80F7FD3143A911F9E6CFD477B0189CAB06@hqemmail02.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/06, Ayaz Abdulla <AAbdulla@nvidia.com> wrote:
> The BIOS will write to the mac address register. The address will be
> written in reverse order.
(Why does the BIOS have to write it out in reverse order? Seems a bit
odd to my simple mind!)

> This bug has already been fixed in the PXE code. Can you let me know
> what version of PXE you are running (it should display the version on
> the screen during boot up)?
I was booting with "Nvidia Boot Agent 240.0532" when I encountered this issue.

Alex Owen
