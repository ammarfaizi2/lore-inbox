Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVBPP7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVBPP7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVBPP7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:59:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:8933 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262056AbVBPP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:59:41 -0500
Date: Wed, 16 Feb 2005 15:58:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Mauricio Lin <mauriciolin@gmail.com>
cc: "Richard F. Rebel" <rrebel@whenu.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
In-Reply-To: <3f250c7105021607022362013c@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0502161554070.18344@goblin.wat.veritas.com>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com> 
    <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com> 
    <1108219160.12693.184.camel@blue.obulous.org> 
    <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com> 
    <3f250c710502160241222dce47@mail.gmail.com> 
    <Pine.LNX.4.61.0502161142240.17264@goblin.wat.veritas.com> 
    <3f250c7105021607022362013c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, Mauricio Lin wrote:
> 
> Thanks by your suggestion. I did not know that kernel 2.4.29 has
> changed the statm implementation. As I can see the statm
> implementation is different between 2.4 and 2.6.
> 
> Let me see if I can use the 2.4.29 statm idea to improve the smaps for
> kernel 2.6.11-rc.

(2.4.29 made no changes there, I think it's unchanged between 2.4.0 and
 2.4.29.  It was 2.5.37 and later 2.5 and 2.6 developments that changed it.)
