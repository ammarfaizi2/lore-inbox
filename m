Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUHOONq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUHOONq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266692AbUHOONq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:13:46 -0400
Received: from quechua.inka.de ([193.197.184.2]:44774 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265808AbUHOONo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:13:44 -0400
Date: Sun, 15 Aug 2004 16:13:42 +0200
From: Bernd Eckenfels <be-mail2004@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove obsolete HEAD in top Makefile
Message-ID: <20040815141342.GB30572@lina.inka.de>
References: <E1BwJne-0006M7-00@calista.eckenfels.6bone.ka-ip.net> <411F58DF.2070002@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <411F58DF.2070002@greatcn.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 08:36:47PM +0800, Coywolf Qi Hunt wrote:
> >iff it is not using it you need to remove it in the next line, too.
> Nah, I'm only removing HEAD, not head-y. :p

If you remove this line:
head-y += $(HEAD)

then head-y is undefined, and could therefore be removed, too. I dont know
what HEAD was used for, and where does it come from. But since the 2.4 code
uses head in a compareable way (i.e. only in that location with toetally
differen s tructure) I am not sure if it is not needed.

Can you explain what it was used for and why it can be removed now?

Gruss
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )      ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o     1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+497211606754
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
