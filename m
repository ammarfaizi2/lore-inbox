Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTABPoc>; Thu, 2 Jan 2003 10:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTABPoc>; Thu, 2 Jan 2003 10:44:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:63496 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262224AbTABPoa>;
	Thu, 2 Jan 2003 10:44:30 -0500
Date: Thu, 2 Jan 2003 16:52:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Michael T. Babcock" <mbabcock@fibrespeed.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unknown error (please help direct it)
Message-ID: <20030102155258.GA956@mars.ravnborg.org>
Mail-Followup-To: "Michael T. Babcock" <mbabcock@fibrespeed.net>,
	linux-kernel@vger.kernel.org
References: <20030102152438.GB12769@godzilla.fibrespeed.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102152438.GB12769@godzilla.fibrespeed.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 10:24:38AM -0500, Michael T. Babcock wrote:
> I have this in my logs from yesterday, with no clear indication as to
> what subsystem it relates to.  Please help me direct this to the appropriate
> persons (and CC me, if possible, in any replies).  There are no kernel messages
> for several minutes before or after these lines.
> 
> 13:50:28 vpn kernel:   Flags; bus-master 1, dirty 2677573(5) current 2677
> 13:50:28 vpn kernel:   Transmit list 00000000 vs. c57ad340.
> 13:50:28 vpn kernel:   0: @c57ad200  length 800005ea status 000105ea

A quick grep told that this line comes from:
drivers/net/3c59x.c

HTH,

	Sam

> 13:50:28 vpn kernel:   1: @c57ad240  length 800003b2 status 000103b2
> 13:50:28 vpn kernel:   2: @c57ad280  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   3: @c57ad2c0  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   4: @c57ad300  length 800005ea status 800105ea
> 13:50:28 vpn kernel:   5: @c57ad340  length 800003b2 status 000103b2
> 13:50:28 vpn kernel:   6: @c57ad380  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   7: @c57ad3c0  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   8: @c57ad400  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   9: @c57ad440  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   10: @c57ad480  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   11: @c57ad4c0  length 800003b2 status 000103b2
> 13:50:28 vpn kernel:   12: @c57ad500  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   13: @c57ad540  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   14: @c57ad580  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   15: @c57ad5c0  length 800005ea status 000105ea
> -- 
> Michael T. Babcock
> CTO, FibreSpeed Ltd.     (Hosting, Security, Consultation, Database, etc)
> http://www.fibrespeed.net/~mbabcock/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
