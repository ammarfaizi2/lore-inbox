Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSLYGJJ>; Wed, 25 Dec 2002 01:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266108AbSLYGJJ>; Wed, 25 Dec 2002 01:09:09 -0500
Received: from polaris.galacticasoftware.com ([206.45.95.222]:36110 "EHLO
	polaris.galacticasoftware.com") by vger.kernel.org with ESMTP
	id <S266101AbSLYGJI>; Wed, 25 Dec 2002 01:09:08 -0500
Date: Wed, 25 Dec 2002 00:16:41 -0600
To: Joao Seabra <seabra@aac.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel GCC Optimizations
Message-ID: <20021225061641.GA6351@mira.lan.galacticasoftware.com>
References: <Pine.LNX.4.33.0212221322260.12768-100000@ci.aac.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212221322260.12768-100000@ci.aac.uc.pt>
User-Agent: Mutt/1.4i
From: Adam Majer <adamm@galacticasoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 01:23:08PM +0000, Joao Seabra wrote:
>  Rename registers from the gcc 3.2 man:
> "Attempt to avoid false dependencies in scheduled code by making
>           use of registers left over after register allocation. This
>           optimization will most benefit processors with lots of
>           registers. It can, however, make debugging impossible, since
>           variables will no longer stay in a "home register"."

Just to be blunt here :), i386 is not one of these register rich
archs. So it will probably not help you to compile with -O3... Of course
you could have something else...

- Adam
