Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVCJWLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVCJWLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbVCJWHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:07:37 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:31956 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263277AbVCJV7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:59:25 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16944.49977.715895.8761@wombat.chubb.wattle.id.au>
Date: Fri, 11 Mar 2005 08:59:21 +1100
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
In-Reply-To: <423082BF.6060007@comcast.net>
References: <423075B7.5080004@comcast.net>
	<423082BF.6060007@comcast.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Richard Moser <nigelenki@comcast.net> writes:


John> I've done more thought, here's a small list of advantages on
John> using binary drivers, specifically considering UDI.  You can
John> consider a different implementation for binary drivers as well,
John> with most of the same advantages.

Almost all these advantages are also present for user-mode drivers...
and getting drivers out of the kernel, where possible, is a much
better approach IMHO than trying to maintain a leaky in-kernel
interface.  The problem with in-kernel interfaces, even if set in
concrete, is that any binary driver can go outside the interface ---
there's no encapsulation --- and so break when the kernel changes.

Peter C


