Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbSIWOWV>; Mon, 23 Sep 2002 10:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSIWOWV>; Mon, 23 Sep 2002 10:22:21 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:37393 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261791AbSIWOWV>; Mon, 23 Sep 2002 10:22:21 -0400
Date: Mon, 23 Sep 2002 15:27:21 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: notifier_call_chain() locking
Message-ID: <20020923142721.GA15243@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17tUBF-000CQ5-00*fmL.ddH0aCc* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why a rw lock when nobody read_lock()s ? Where is the locking of
notifier_call_chain() against concurrent [un]registers ?

regards
john
-- 
"Say what you mean or you won't mean a thing to me."
        - Embrace
