Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289036AbSAIVy6>; Wed, 9 Jan 2002 16:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289033AbSAIVyt>; Wed, 9 Jan 2002 16:54:49 -0500
Received: from nile.gnat.com ([205.232.38.5]:54416 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289036AbSAIVyi>;
	Wed, 9 Jan 2002 16:54:38 -0500
From: dewar@gnat.com
To: dewar@gnat.com, pkoning@equallogic.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, mrs@windriver.com
Message-Id: <20020109215438.1748DF2FEB@nile.gnat.com>
Date: Wed,  9 Jan 2002 16:54:38 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Would ordering rules help answer that?  If you write two separate
loads you have two separate side effects that are ordered in time,
while for a single big load they occur concurrently.  If the construct
where those two loads occur does not allow for side effects to be
interleaved, then the "as if" principle seems to say you cannot
legally merge the loads.
>>

Yes maybe, but it's not air tight :-)
