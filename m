Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUG1Qo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUG1Qo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUG1Qo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:44:27 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:64645
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S267298AbUG1Qmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:42:33 -0400
From: Rob Landley <rob@landley.net>
To: Paul Jackson <pj@sgi.com>
Subject: Re: Interesting race condition...
Date: Wed, 28 Jul 2004 11:42:37 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200407222204.46799.rob@landley.net> <20040728010546.3b7933d5.pj@sgi.com>
In-Reply-To: <20040728010546.3b7933d5.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407281142.37194.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 July 2004 03:05, Paul Jackson wrote:
> Rob wrote:
> > I just saw a funky thing.  Here's the cut and past from the xterm...
>
> Can you reproduce this by cat'ing /proc/<pid>/cmdline?  Can you get a
> dump of the proc cmdline file to leak the environment sometimes?

I saw it exactly once, I'm afraid.  Somebody else said they also saw it...  
once.  It smelled to me like a race condition, with the process 
starting/exiting right as ps looked at it, but I haven't seen it again.  (I 
could run the command in a loop overnight...)

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

