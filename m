Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbTFRUTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbTFRUTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:19:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:6410 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265458AbTFRUSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:18:54 -0400
Date: Wed, 18 Jun 2003 22:32:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       roland@redhat.com
Subject: Re: common name for the kernel DSO
Message-ID: <20030618203247.GA14124@mars.ravnborg.org>
Mail-Followup-To: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org, roland@redhat.com
References: <16112.47509.643668.116939@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16112.47509.643668.116939@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 12:12:21PM -0700, David Mosberger wrote:
> Not surprisingly, I like the name "linux-gate", since that is really
> what this DSO is all about: it's a gateway between user and kernel
> space.  However, if this name isn't appropriate for x86, perhaps we
> can find another name which will be acceptable to everybody.

Hi David.

I see no clean way to share the rules between the architectures,
at least not without doing something very special for this.
The second best alternative is to have the same implementation
in all architectures supporting this, so my vote goes for the
gate name.

PS. One day I hope to find a better solution for the gross ld_flags hack..

	Sam
