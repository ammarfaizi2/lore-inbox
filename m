Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262247AbSJEJDC>; Sat, 5 Oct 2002 05:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262251AbSJEJDC>; Sat, 5 Oct 2002 05:03:02 -0400
Received: from brev.stud.ntnu.no ([129.241.56.70]:53191 "EHLO
	brev.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S262247AbSJEJDC>; Sat, 5 Oct 2002 05:03:02 -0400
Date: Sat, 5 Oct 2002 11:07:05 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: Unable to kill processes in D-state
Message-ID: <20021005090705.GA18475@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We have a fairly large installation on-campus, and we have some problems
with the current linux-kernel (and older ones) - namely that processes
entering D-state will stay there forever (given that the right event got
them there in the first place).  This right event is killing the 
autofs-daemon.  Doing this will result in heavy load because of lots
of D-state processes, and you can't kill any of the D-state processes.
Why shouldn't one be able to kill processes that has entered D-state?
We have to reboot our servers to get rid of this problem, and it's
rather annoying.

-- 
Thomas
