Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTI2RO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbTI2RNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:13:22 -0400
Received: from dsl-213-023-220-234.arcor-ip.net ([213.23.220.234]:10372 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S263819AbTI2RKS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:10:18 -0400
From: Dominik Kubla <dominik@kubla.de>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check headers for complete includes, etc.
Date: Mon, 29 Sep 2003 19:10:16 +0200
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <20030929145057.GA1002@mars.ravnborg.org> <20030929150005.GA24375@wohnheim.fh-wedel.de>
In-Reply-To: <20030929150005.GA24375@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309291910.16733.dominik@kubla.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 29. September 2003 17:00 schrieb Jörn Engel:
>
> Would work.  But I'd prefer to have that information inside the header
> files, under some syntax.
>
> /* attr: indirect header */
>
> Is this acceptable?

Just a suggestion: Make it a define. Comments tend to be re-formatted, 
"improved", deleted, etc. You get the picture. So I think that:

#define PRAGMA_INDIRECT_HEADER	TRUE

(or something similiar) would be better suited.

Regards,
  Dominik
-- 
Those who can make you believe absurdities can make you commit
atrocities.    (Francois Marie Arouet aka Voltaire, 1694-1778)

