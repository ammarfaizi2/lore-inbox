Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbREUIjn>; Mon, 21 May 2001 04:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262407AbREUIje>; Mon, 21 May 2001 04:39:34 -0400
Received: from t2.redhat.com ([199.183.24.243]:2551 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262402AbREUIjX>; Mon, 21 May 2001 04:39:23 -0400
To: mirabilos <eccesys@topmail.de>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 00_rwsem-11, 2.4.4-ac11 and gcc-3(2001-05-14) 
In-Reply-To: Message from mirabilos <eccesys@topmail.de> 
   of "Fri, 18 May 2001 22:08:37 +0200." <20010518200837.ED2FDA5AF76@www.topmail.de> 
Date: Mon, 21 May 2001 09:39:16 +0100
Message-ID: <31508.990434356@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The compiler should be now fixed in this respect, for both my stuff that's in
the kernel and Andrea's desired replacement. The problem appears to have been
triggered by having two "input+output" constraints (eg: "+r", "+m"). However,
I can't test this because the head of the CVS trunk doesn't seem to have been
able to build and test successfully since just before the fix was
applied. (I'm going on the codesourcery builds for this).

David
