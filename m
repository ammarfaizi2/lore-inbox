Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbTCTSm5>; Thu, 20 Mar 2003 13:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTCTSm5>; Thu, 20 Mar 2003 13:42:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1034 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261764AbTCTSm4>;
	Thu, 20 Mar 2003 13:42:56 -0500
Date: Thu, 20 Mar 2003 19:53:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Paolo Ornati <javaman@katamail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HELP: Building System
Message-ID: <20030320185356.GA942@mars.ravnborg.org>
Mail-Followup-To: Paolo Ornati <javaman@katamail.com>,
	linux-kernel@vger.kernel.org
References: <20030320144039Z261488-25575+33284@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320144039Z261488-25575+33284@vger.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 03:50:49PM +0100, Paolo Ornati wrote:
> I think that the available Documentetion about "REcompiling a kernel" is a 
> little confusing (about the use of "make clean").

Did you try to read README in the top-level directory?

Anyway "make clean" deletes most of the generated files, but most
important leaves the actual .config.
"make mrproper" cleans up stuff even more, but remember to save/restore
.config when using "make mrproper".

	Sam
