Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288977AbSA3IXN>; Wed, 30 Jan 2002 03:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288984AbSA3IXI>; Wed, 30 Jan 2002 03:23:08 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31182 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S288956AbSA3IWE>;
	Wed, 30 Jan 2002 03:22:04 -0500
Date: Wed, 30 Jan 2002 03:22:02 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help in 2.5.3-pre6
Message-ID: <20020130032202.F32317@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.33.0201292147530.22800-100000@barbarella.hawaga.org.uk> <1012370595.3392.21.camel@phantasy> <a3847v$17m$1@penguin.transmeta.com> <20020130075444.GA401@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130075444.GA401@hydra>; from oxygene@studentenbude.ath.cx on Wed, Jan 30, 2002 at 08:54:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:54:44AM +0100, Patrick Mauritz wrote:
> short being between now and the cml2 inclusion?

CML2 is butt-ugly to read and maintain, at least for drivers.  It is
my hope that Eric will take input that will make CML2 more readable
and useable by kernel hackers.

The current config language, for all the flaws CML2 proponents love to
point out, is quite readable and understandable.  It doesn't force
the entire domain of CONFIG_xxx symbols on you, like CML2 does.
[Unless this has changed recently] CML2 forces architecture X to be
mindful of changes in architecture Y.  For some tasks this make sense,
but for other cases this is a completely needless usurpation of an
architecture's control of the CONFIG_xxx namespace.  The current
config language allows an arch to -control- the namespace, while
CML2 appears to reduce flexibility by requiring global instead of
arch-specific control of the namespace.

It is my hope that some sort of compromise can be found... :(

	Jeff
