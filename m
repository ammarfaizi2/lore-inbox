Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbUJYTaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUJYTaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUJYT27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:28:59 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:30848 "EHLO
	midnight.suse.cz") by vger.kernel.org with ESMTP id S262041AbUJYQEt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:04:49 -0400
Date: Mon, 25 Oct 2004 18:04:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041025160427.GA2002@ucw.cz>
References: <200410210154.58301.dtor_core@ameritech.net> <20041025125629.GF6027@crusoe.alcove-fr> <20041025135036.GA3161@crusoe.alcove-fr> <20041025135742.GA1733@ucw.cz> <20041025144549.GD3161@crusoe.alcove-fr> <20041025151120.GA1802@ucw.cz> <20041025152023.GE3161@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025152023.GE3161@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 05:20:24PM +0200, Stelian Pop wrote:
> xev doesn't say anything about modifiers. It shows the modifier being
> pressed, the other key pressed, then released, then the modifier being
> released too.
> 
> The trace shows the same kind of events in a working Control case or
> in a not working 'function' case:
> 
> KeyPress event, serial 24, synthetic NO, window 0x2a00001,
>     root 0x40, subw 0x2a00002, time 6566259, (37,47), root:(542,70),
>     state 0x0, keycode 214 (keysym 0x8f6, function), same_screen YES,
>     XLookupString gives 0 bytes: 
>     XmbLookupString gives 0 bytes: 
>     XFilterEvent returns: False
> 
> KeyPress event, serial 24, synthetic NO, window 0x2a00001,
>     root 0x40, subw 0x2a00002, time 6566259, (37,47), root:(542,70),
>     state 0x20, keycode 67 (keysym 0xffbe, F1), same_screen YES,
>     XLookupString gives 0 bytes: 
>     XmbLookupString gives 0 bytes: 
>     XFilterEvent returns: False
> 
> KeyRelease event, serial 24, synthetic NO, window 0x2a00001,
>     root 0x40, subw 0x2a00002, time 6566259, (37,47), root:(542,70),
>     state 0x20, keycode 67 (keysym 0xffbe, F1), same_screen YES,
>     XLookupString gives 0 bytes: 
> 
> KeyRelease event, serial 24, synthetic NO, window 0x2a00001,
>     root 0x40, subw 0x2a00002, time 6566259, (37,47), root:(542,70),
>     state 0x20, keycode 214 (keysym 0x8f6, function), same_screen YES,
>     XLookupString gives 0 bytes: 
 
Watch the "state" variable.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
