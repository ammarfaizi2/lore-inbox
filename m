Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUH1AKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUH1AKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUH1AKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:10:15 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14210
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S265722AbUH1AKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:10:09 -0400
Date: Fri, 27 Aug 2004 17:09:51 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Dave Airlie <airlied@linux.ie>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: maintaining DRM and using bitkeeper..
Message-Id: <20040827170951.3ad3900e.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0408280046220.23054@skynet>
References: <Pine.LNX.4.58.0408270043170.25111@skynet>
	<20040827173807.GB7445@mars.ravnborg.org>
	<Pine.LNX.4.58.0408280046220.23054@skynet>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004 00:54:06 +0100 (IST)
Dave Airlie <airlied@linux.ie> wrote:

> This is my main issue with using bitkeeper vs separate patches, if I check
> the macro conversion into bitkeeper as separate patches each removing a
> couple of inter-related macros (this is my intention... it is what I did
> in the DRM CVS tree) and I ask Linus to pull it from a tree, will it not
> look like one big patch (albeit in a number of changesets...)

No, this will look perfectly fine.  This is exactly how things are
supposed to work.

When you ask for a pull, you can just concatenate the individual changesets
as patches, and it looks really nice.  That is what I do when I send a pull
request to Marcelo or Linus.
