Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVLNLYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVLNLYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVLNLYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:24:18 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:57697 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932419AbVLNLYR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:24:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=elhFDJEI/4U9TBNfmrIbk8IgeuHOVGaTVnPY0/uR2NK3Wr56PcYd4iCW0VS9aMElBmcPQnQl3606QlqQSCwIZa9ebD1zevmfbLybwlVTi7hgoPjcdSwu0lkeWhrivlDnnm9/MnxAOYZLy5A+bqb5MmSBcYqogf1pTj2uy9wPgSQ=
Message-ID: <7accf3e60512140324x6570a65bk319f9ff11b6e8c93@mail.gmail.com>
Date: Wed, 14 Dec 2005 16:54:16 +0530
From: Prabhat Hegde <hegde.prabhat@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: querry on DMA
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends,
can any1 point me to a good linux memory management stuff. Actually i
want to know the conversion of virtual to physical address and when u
need to do it. I am seeking to do some dma from the host memory to an
ethernet device. I have registered my own device data structures,
while booting my device. i.e it seeks all the memory it needs at
startup. later i put the data to the device specific data structures &
ring a doorbell register later upon which the device picks up the
data. This is my plan. But i am facing some problems during dma time.
So can someone throw some light as to how to do this in a generic way
so that later i can customise it?
