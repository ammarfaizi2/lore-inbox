Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTA0K13>; Mon, 27 Jan 2003 05:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTA0K13>; Mon, 27 Jan 2003 05:27:29 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:30628 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267059AbTA0K12>;
	Mon, 27 Jan 2003 05:27:28 -0500
Date: Mon, 27 Jan 2003 11:36:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: yokotak@rmail.plala.or.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gamecon (added support for Sega Saturn controller), kernel 2.4.20
Message-ID: <20030127113636.A9329@ucw.cz>
References: <20030126113957.A21550@ucw.cz> <20030127103408.GALG26766.mps4.plala.or.jp@rmail.mail.plala.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030127103408.GALG26766.mps4.plala.or.jp@rmail.mail.plala.or.jp>; from yokotak@rmail.plala.or.jp on Mon, Jan 27, 2003 at 07:34:10PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 07:34:10PM +0900, yokotak@rmail.plala.or.jp wrote:

> Thank you very much for your reply.
> 
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> > Why are you adding it into gamecon.c and not fixing it in db9.c instead?
> 
> Db9.c supports ONE gamepad per port. Gamecon.c supports FIVE gamepads
> per port.

Two in some cases. And that's the number of Saturn pads supported by
your patch as well, right?

> Gamecon.c seems appropriate to support more than one sega saturn pad
> on DPP compatible interface and multitap.

Gamecon is based on that it uses one input line per device. The Saturn
needs more than one (four?).

-- 
Vojtech Pavlik
SuSE Labs
