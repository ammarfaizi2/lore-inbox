Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291389AbSAaXJT>; Thu, 31 Jan 2002 18:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291388AbSAaXJA>; Thu, 31 Jan 2002 18:09:00 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19082 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290495AbSAaXIo>;
	Thu, 31 Jan 2002 18:08:44 -0500
Date: Thu, 31 Jan 2002 18:08:42 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "David S. Miller" <davem@redhat.com>
Cc: vandrove@vc.cvut.cz, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        paulus@samba.org, davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does not
Message-ID: <20020131180842.A13730@havoc.gtf.org>
In-Reply-To: <107F105A2B71@vcnet.vc.cvut.cz> <20020131153115.A5370@havoc.gtf.org> <20020131225306.GA23758@vana.vc.cvut.cz> <20020131.145904.41634460.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131.145904.41634460.davem@redhat.com>; from davem@redhat.com on Thu, Jan 31, 2002 at 02:59:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 02:59:04PM -0800, David S. Miller wrote:
> As a side note, this thing is so tiny (less than 4K on sparc64!) so
> why don't we just include it unconditionally instead of having all
> of this "turn it on for these drivers" stuff?

Does that 4K include the BE and LE crc tables?

<shrug>  I don't mind much either way, except that I am general
resistant to "turn this on unconditionally" for bloat reasons.
[ie. its a reflex :)]

	Jeff



