Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271081AbUJVIck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271081AbUJVIck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271182AbUJVIcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:32:36 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:19730 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269752AbUJVIXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:23:37 -0400
Date: Fri, 22 Oct 2004 10:29:26 +0200
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Tomas Carnecky <tom@dbservice.com>, linux-kernel@vger.kernel.org
Subject: Re: my opinion about VGA devices
Message-ID: <20041022082926.GA15661@hh.idb.hist.no>
References: <417590F3.1070807@dbservice.com> <41763D7C.26451.1B52EDE7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41763D7C.26451.1B52EDE7@localhost>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 10:27:08AM -0700, Kendall Bennett wrote:
[...]
> As for the framebuffer console, it exists purely to get high resolution 
> text consoles working with basic graphics capabilities. It was never 
> intended to be a complete graphics environment, but just the console that 
> can be used in graphics modes. The original versions of the framebuffer 
> console code were developed not for x86 machines but for non-x86 machines 
> that did not have any VGA capabilities at all (ie: Mac's). For Linux to 
> work on such machines, the console needed to be able to output text in 
> graphics modes since that is what the machines booted in. Once this was 
> done for non-x86 boxes, it was realised this would be a 'cool' feature 
> for x86 machines for two reasons. 1 - you get a nice high resolution text 
> console, way better than VGA text mode and, 2 - you can display the cool 
> penguin logo ;-)

And last but not least - you can have several such framebuffers in a
single machine, possibly for multi-user purposes.  VGA
wants to be the only one of its kind . . .

Helge Hafting
