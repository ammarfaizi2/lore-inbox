Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTENCkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 22:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTENCkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 22:40:37 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:50818
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262252AbTENCkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 22:40:36 -0400
Date: Tue, 13 May 2003 22:43:48 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: "'Shaheed R. Haque'" <srhaque@iee.org>, "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6 must-fix list, v2
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780CCB07F4@orsmsx116.jf.intel.com>
Message-ID: <Pine.LNX.4.50.0305132238550.14103-100000@montezuma.mastecende.com>
References: <A46BBDB345A7D5118EC90002A5072C780CCB07F4@orsmsx116.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Perez-Gonzalez, Inaky wrote:

> Real time applications can also benefit from this; if I can
> get all the random stuff out of the way so that I know the
> important, timing-sensitive thingie in CPU1 will always
> get it, bonus points! ...

Not really, during load your reserved cpu will now have to wait longer 
for shared resources instead of helping make progress, bringing down the 
performance of all your applications including the 'realtime' one.

	Zwane
-- 
function.linuxpower.ca
