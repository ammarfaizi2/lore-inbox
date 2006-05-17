Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWEQAzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWEQAzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWEQAzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:55:50 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:17301 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751007AbWEQAzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:55:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17514.29815.521207.416872@wombat.chubb.wattle.id.au>
Date: Wed, 17 May 2006 10:55:19 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: James Morris <jmorris@namei.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: endian fix
In-Reply-To: <Pine.LNX.4.64.0605161149540.16379@d.namei>
References: <20060516152305.GI10143@mipter.zuzino.mipt.ru>
	<Pine.LNX.4.64.0605161149540.16379@d.namei>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Morris <jmorris@namei.org> writes:

James> On Tue, 16 May 2006, Alexey Dobriyan wrote:
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

James> Hmm, I'm certain this was tested (perhaps on a BE machine,
James> though). In any case skb->protocol should definitely be network
James> byte order.

On all architectures, ntohs is the same as htons -- either the two
bytes are swapped or they're not.


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
