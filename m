Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTGBUMM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTGBUMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:12:12 -0400
Received: from faui10.informatik.uni-erlangen.de ([131.188.31.10]:32238 "EHLO
	faui10.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S264456AbTGBUML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:12:11 -0400
From: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Message-Id: <200307022023.WAA21955@faui11.informatik.uni-erlangen.de>
Subject: Re: crypto API and IBM z990 hardware support
To: jmorris@intercode.com.au
Date: Wed, 2 Jul 2003 22:23:31 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org, tspat@de.ibm.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

>Are there any details available on how all of this is implemented?  Are 
>these instructions synchronous?

FYI, the relevant instructions are documented in the z/Architecture
Principles of Operation, available on the Web at:

http://publibfp.boulder.ibm.com/cgi-bin/bookmgr/BOOKS/dz9zr002

Check Chapter 7 for the instructions:
CHIPER MESSAGE (KM)
CHIPER MESSAGE WITH CHAINING (KMC)
COMPUTE INTERMEDIATE MESSAGE DIGEST (KIMD)
COMPUTE LAST MESSAGE DIGEST (KLMD)
COMPUTE MESSAGE AUTHENTICATION CODE (KMAC)

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
