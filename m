Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWDYGbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWDYGbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWDYGbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:31:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34961 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932118AbWDYGa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:30:59 -0400
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for
	run-timeauthentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: Nix <nix@esperi.org.uk>
Cc: "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       disec-devel@lists.sourceforge.net
In-Reply-To: <87zmiao8bq.fsf@hades.wkstn.nix>
References: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
	 <1145897277.3116.44.camel@laptopd505.fenrus.org>
	 <87hd4ipvdk.fsf@hades.wkstn.nix>
	 <1145911526.3116.71.camel@laptopd505.fenrus.org>
	 <87zmiao8bq.fsf@hades.wkstn.nix>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 08:30:50 +0200
Message-Id: <1145946650.3114.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 00:35 +0100, Nix wrote:
> On Mon, 24 Apr 2006, Arjan van de Ven yowled:
> > On Mon, 2006-04-24 at 21:32 +0100, Nix wrote:
> >> It checks mmap and mprotect with PROT_EXEC, and execve().
> > 
> > so no jvm's or flash plugins.
> 
> Well, you'll have to sign the flash plugin. This isn't
> sign-at-compilation-time; 

the point I made is that a jvm has executable memory capabilities (it
has to) and can be made an elf loader. At which point.. game over.



> > so it's not all that easy as you make it sound
> 
> Everyone seems to want the One Security Fix To Rule Them All. 

I'm not part of that "everyone". I'm all in favor of removing degrees of
freedom. However this one doesn't, it's just pure fake. This is similar
to posting a sign at your unlocked front door "please don't burgle me
via my front door" while your windows are also open.

