Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbRL1Upk>; Fri, 28 Dec 2001 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287044AbRL1UpZ>; Fri, 28 Dec 2001 15:45:25 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40118 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S287042AbRL1Uoj>;
	Fri, 28 Dec 2001 15:44:39 -0500
Date: Fri, 28 Dec 2001 15:41:51 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228154151.B27313@havoc.gtf.org>
In-Reply-To: <20011228042648.A7943@havoc.gtf.org> <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 28, 2001 at 10:02:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 10:02:01AM -0800, Linus Torvalds wrote:
> Something I also asked for the config system at least a year ago was to
> have Configure.help split up. Never happened. It's still one large ugly
> file. Driver or architecture maintainers still can't just change _their_
> small fragment, they have to touch a global file that they don't "own".
> 
> So if somebody really wants to help this, make scripts that generate
> config files AND Configure.help files from a distributed set. And once you
> do that, you could even imagine creating the old-style config files
> (without the automatic checking and losing some information) from the
> information.

For single-file drivers, I like Becker's (correct credit?) system...
about 10 lines of metadata is embedded in a C comment, and it includes
the Config.in and Configure.help info.

	Jeff


