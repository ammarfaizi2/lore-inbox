Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310335AbSCAGee>; Fri, 1 Mar 2002 01:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310331AbSCAGca>; Fri, 1 Mar 2002 01:32:30 -0500
Received: from pcp809261pcs.nrockv01.md.comcast.net ([68.49.81.201]:14476 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S310345AbSCAG3e>; Fri, 1 Mar 2002 01:29:34 -0500
Date: Fri, 1 Mar 2002 01:29:33 -0500
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <20020301012933.A6621@zalem.nrockv01.md.comcast.net>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020228215025.3310A-100000@gatekeeper.tmr.com> <Pine.LNX.4.33L.0203010009510.2801-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0203010009510.2801-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Mar 01, 2002 at 12:13:08AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 12:13:08AM -0300, Rik van Riel wrote:
> You can send marcelo such a patch (without the scheduler) right
> now.

And it's even probably a better idea to send it without the scheduler.
It's a typical Al Viro[tm] patch, change a repeated group of code into
one macro/function with zero impact on the resulting code, only better
encapsulation.  It is completely orthogonal to the scheduler, and
obviously low risk.

  OG.

