Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUD0Tns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUD0Tns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUD0TmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:42:09 -0400
Received: from piedra.unizar.es ([155.210.11.65]:5510 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S264310AbUD0Tl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:41:57 -0400
From: "Jorge Bernal (Koke)" <koke_lkml@amedias.org>
Reply-To: koke@sindominio.net
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Tue, 27 Apr 2004 21:41:51 +0200
User-Agent: KMail/1.6.1
Cc: Grzegorz Kulewski <kangur@polcom.net>, Valdis.Kletnieks@vt.edu
References: <20040427165819.GA23961@valve.mbsi.ca> <200404272103.21925.koke_lkml@amedias.org> <Pine.LNX.4.58.0404272113110.9618@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0404272113110.9618@alpha.polcom.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404272141.51222.koke_lkml@amedias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Martes, 27 de Abril de 2004 21:16, Grzegorz Kulewski wrote:
>
> I think that /proc/tainted would be better than spamming logs after each
> load of tainted module...
> But probably modules should not be removed from /proc/tainted on unloading
> (to prevent from "un-tainting" the kernel by "clever" users).
>

2 ideas:

Printing if the tainted module is loaded or unloaded

and/or

using the /proc/tainted interface to enable/disable loading of tainted 
modules.

So that are 2 different things: a) how do we handle the tainted mods 
notifications and b) if we let the user decide if he/she wants tainted 
modules to be "blocked"

