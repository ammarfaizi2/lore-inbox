Return-Path: <linux-kernel-owner+w=401wt.eu-S1161162AbXAMAyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbXAMAyE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbXAMAyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:54:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:43815 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161162AbXAMAyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:54:02 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=lg1UmXsHZl41cTxkoPoumjmQAfbG9613A960y2OUiAz4XW0fKYgJYeogow7k28BkNBnU7oMW9Y4EGLCH1j7kY+igM8vDc1Khe8DmkWCdAOg0sF1wfLWtFrx05HdaDF/7unS0kohQinA+4xId7TtVlYWUb8z+OjjoKqsdoXC5ziM=
Message-ID: <45A82DA0.6050801@gmail.com>
Date: Sat, 13 Jan 2007 09:53:52 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Mark Wagner <mark@lanfear.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sata_sil24 lockups under heavy i/o
References: <20070103173024.GB17650@freddy.lanfear.net> <20070104181601.GD17650@freddy.lanfear.net> <45A092B7.4070301@gmail.com> <20070112183514.GA30434@freddy.lanfear.net>
In-Reply-To: <20070112183514.GA30434@freddy.lanfear.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Wagner wrote:
> The sil24-connected sata drives are external and connected to their own
> power supply.
> 
> I've replaced the sil24-based card with a Promise SATA300 TX4 controller
> card and everything seems to work now.

Hmmm... sil24 fares well with four ports occupied.  Weird.  Care to give
it another shot?  Maybe pci bus contact was bad or something.

-- 
tejun
