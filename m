Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268306AbRGWRXY>; Mon, 23 Jul 2001 13:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268307AbRGWRXO>; Mon, 23 Jul 2001 13:23:14 -0400
Received: from adsl-65-69-43-155.dsl.stlsmo.swbell.net ([65.69.43.155]:65422
	"HELO sbox.labfire.com") by vger.kernel.org with SMTP
	id <S268306AbRGWRXC>; Mon, 23 Jul 2001 13:23:02 -0400
Date: Mon, 23 Jul 2001 12:22:49 -0500
From: Ian Wehrman <ian@labfire.com>
To: linux-kernel@vger.kernel.org
Subject: squashing with knfsd
Message-ID: <20010723122249.A20863@labfire.com>
Reply-To: ian@labfire.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

hello all,
i was wondering if someone could confirm that the "all_squash" and "anongid"
keywords are functional in the 2.4 knfs daemon? i can't seem to get this to
work... my /etc/exports file looks like this:

/home bowman(rw,all_squash,anongid=501)

yet no gid mapping seems to be occuring. actually, no squashing of any sort
works (not even root_squash'ing to the nobody user). is there some trick to
this, uid mapping like this even supposed to work with knfsd? 
any thoughts would be most appreciated.

thanks in advance,
ian wehrman

-- 
Labfire, Inc.
Seamless Technical Solutions
http://labfire.com/
