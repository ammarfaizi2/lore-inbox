Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVEJRa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVEJRa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 13:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVEJRa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 13:30:29 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:27051 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261715AbVEJRaX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 13:30:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BExwAK/aLCXATV1Tyk0esp98/YHqQl7UynTWvjBC8JKBUa2xfTtw1K0noDo6QwqNNZtxnxM7/Vw0Rx4ybYTEPz2Gl4j4ObtBeNw+7uZJ/CZ//x72ogJ2X87WKDV7NQdT9W3O9zjI1uStao4PQm8t7ncSsBdKL4yq7JbxgotnB7A=
Message-ID: <d120d5000505101030f0bbad6@mail.gmail.com>
Date: Tue, 10 May 2005 12:30:23 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Mitch <Mitch@0bits.com>
Subject: Re: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4280E1E8.4040906@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4280E1E8.4040906@0Bits.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Mitch <Mitch@0bits.com> wrote:
> Hi Dimitry,
> 
> Still no go. With ps2_drain() commented (not enabled) the touchpad mouse
> is completely unresponsive. With ps2_drain() un-commented, there is
> initial life, but it hangs shortly after that. Log attached.
> 

Thank you for the log. V8 is uploaded. Alternatively, just change
psmouse->pktcnt to psmouse->pktsize in
drivers/input/mouse/alps.c::alps_poll().


-- 
Dmitry
