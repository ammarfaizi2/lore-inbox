Return-Path: <linux-kernel-owner+willy=40w.ods.org-S275850AbVBDEj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275850AbVBDEj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 23:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275863AbVBDEj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 23:39:26 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:58583 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S275850AbVBDEjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 23:39:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Stl4mAMn8O54lvfqvKz3wIoJ8h9K9aoDfHFODiYNUV1uluGHJKO58yqQfTbl2h169I8kAoRCOUf2F103AbzjMuQU7X0ERK0FdFtKAxFxwfYgKk7NZ6pkmLG3N6D+272CxKSsS6nqYoOyM7YZVygoMg7iLq0nCEm9kt87X//pf4s=
Message-ID: <a71293c2050203203951ad1793@mail.gmail.com>
Date: Thu, 3 Feb 2005 23:39:21 -0500
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200502032252.45309.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c20502031443764fb4e5@mail.gmail.com>
	 <200502031934.16642.dtor_core@ameritech.net>
	 <200502032252.45309.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005 22:52:44 -0500, Dmitry Torokhov
<dtor_core@ameritech.net> wrote:
> OK, I have read the code once again, and saw that you have special
> handling within PS/2 protocol based on model constant. Please set
> psmouse type to PSMOUSE_TRACKPOINT instead of model and provide full
> protocol handler, like ALPS, Synaptics and Logitech do. Trackpoint
> is different and complex enough to warrant it.

Thanks, I've made all the changes suggested and I'll incorporate this
too. I'll send a new patch at the end of the weekend when I get back.


Stephen
