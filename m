Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVBHQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVBHQzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVBHQzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:55:05 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:22365 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261566AbVBHQzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:55:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=G8H2D1HMhabOeneCRYpMi9cDRrwuLjuPExu6pDTrlzgP92/hQL+YrxJBum1N03Hwf0g2sWJpSpPlPVEHTAA104qpjlskNsi278KSXqtVf/vHxUrOsFBPs6k3QboMxb2XGah3J75OWH8qfUTTdGL+bXLZiHJlU1DketpmMGkSlwM=
Message-ID: <d120d50005020808542f67deb3@mail.gmail.com>
Date: Tue, 8 Feb 2005 11:54:58 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050208164227.GA9790@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050208164227.GA9790@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005 17:42:27 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> Hi!
> 
> I've written a driver for probably the most common touchscreen type -
> the serial Elo touchscreen.
> 

Hi,

Looks very nice, unfortunately I don;t have a touchscreen to test it.
One thing - now that kcalloc in the mainline I find myself using it
more and more instead of kmalloc + memtest.

-- 
Dmitry
