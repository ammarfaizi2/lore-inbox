Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbTJYV10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTJYV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:27:26 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52929
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263004AbTJYV1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:27:25 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Kconfig choice menu help text is not working in -test8
Date: Sat, 25 Oct 2003 16:24:07 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310250244.56881.rob@landley.net> <20031025112637.GA901@mars.ravnborg.org>
In-Reply-To: <20031025112637.GA901@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310251624.07665.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 October 2003 06:26, Sam Ravnborg wrote:
> On Sat, Oct 25, 2003 at 02:44:56AM -0500, Rob Landley wrote:
> > I'm banging away on the bzip patch, adding a choice menu to kconfig for
> > bzip/gzip/uncompressed, and I notice that the help text isn't working
> > right.
>
> Anders Gustafsson <andersg@0x63.nu> posted this patch some time ago.
> I never came around testing it.
>
> 	Sam

I just tested it.  No effect on this problem, maybe it fixes something else...

(Looking at the patch, it prints stuff to stderr, adds adds a "selected" case 
to something that was previously on/off...  I don't think it's really 
addressing this issue...)

Rob

