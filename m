Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbSKEDLR>; Mon, 4 Nov 2002 22:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274800AbSKEDLR>; Mon, 4 Nov 2002 22:11:17 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:47367 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S268971AbSKEDLQ>; Mon, 4 Nov 2002 22:11:16 -0500
Date: Tue, 5 Nov 2002 03:16:57 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initializer conversions for drivers/block
Message-ID: <20021105031657.GA37603@compsoc.man.ac.uk>
References: <20021105031120.52D152C292@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105031120.52D152C292@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *188uDU-00090J-00*bJzUMt2xCmo* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 01:59:35PM +1100, Rusty Russell wrote:

> @@ -96,7 +96,7 @@ static int ps2esdi_read_status_words(int
>  
>  static void dump_cmd_complete_status(u_int int_ret_code);
>  
> -static void ps2esdi_get_device_cfg(void);
> + static void ps2esdi_get_device_cfg(void);

This seems to be crufty change.

regards
john

-- 
"When a man has nothing to say, the worst thing he can do is to say it
memorably."
	- Calvin Trillin
