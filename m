Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWEDP3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWEDP3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWEDP3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:29:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41070 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751508AbWEDP3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:29:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sf64ppd58lm9rNeC6xTpVw2jBdukKtWGAU0uiaAo51OZTkc63CpSFF4IDm9vqYQT05zlArQBek4oFyLCxzplihbnYze+6vKeyhq5HyT6PNrEMsyAuGRPXJ5ZCEjUw94w0LJYL+Ht0GbgmW8n/UcKRk89V2XX8zwz0JWBtax2RUQ=
Message-ID: <6051e9370605040829v39713634w4c4730effa4b509d@mail.gmail.com>
Date: Thu, 4 May 2006 20:59:21 +0530
From: "Priyanka Sharma" <sharmapriyanka5@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: getting problem in netpoll..
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ebody,

i m working on linux kenel version-2.6.16.
i m calling function netpoll_send_udp tht is in
linux/net/core/netpoll.c in my module.
& i m passing it struct netpoll *np, but i don't knw how to set
net_device *dev in structure.
like if we see in netconsole module it is not assigning any device in
net_device in netpoll structure.
so im getting problem when i calls netpoll_send_udp in netpoll.c file
from my module.
please, can any one tell me how can debug this problem??

thanks
Priyanka
