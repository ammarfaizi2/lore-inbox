Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290121AbSAORkH>; Tue, 15 Jan 2002 12:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290119AbSAORj6>; Tue, 15 Jan 2002 12:39:58 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:64523 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S290114AbSAORjr>;
	Tue, 15 Jan 2002 12:39:47 -0500
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
Date: 15 Jan 2002 18:38:59 +0100
Organization: Cistron Internet Services
Message-ID: <a21pfj$amj$1@picard.cistron.nl>
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local> <200201151653.g0FGrlG12428@vindaloo.ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200201151653.g0FGrlG12428@vindaloo.ras.ucalgary.ca>,
Richard Gooch  <rgooch@ras.ucalgary.ca> wrote:
>Having to set the permissions like this on each boot seems a bit
>painful. Why not have permissions persistence like devfs has?

Maybe you could abstract that persistency from devfs and move
it into a general layer that other filesytems can also use.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

