Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbRFNOEs>; Thu, 14 Jun 2001 10:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbRFNOEi>; Thu, 14 Jun 2001 10:04:38 -0400
Received: from dsl-64-192-96-25.telocity.com ([64.192.96.25]:19720 "EHLO
	orr.falooley.org") by vger.kernel.org with ESMTP id <S262865AbRFNOEg>;
	Thu, 14 Jun 2001 10:04:36 -0400
Date: Thu, 14 Jun 2001 10:03:54 -0400
From: Jason Lunz <j@falooley.org>
To: linux-kernel@vger.kernel.org
Cc: almesber@lrc.di.epfl.ch
Subject: Re: RFC: from FIBMAP to FIONDEV
Message-ID: <20010614100354.A2129@orr.falooley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking for a way to do FIBMAP on linux 2.4 without being root, and
I learned from the archive that it's restricted for security reasons,
and that it's obsolete anyway.  I found this discussion about a
replacement called FIONDEV:

http://uwsg.iu.edu/hypermail/linux/kernel/9906.1/0817.html

However, I can't find any reference to FIONDEV in current 2.4 sources.
Was anything similar ever coded? Is there a better way then FIBMAP to
get the lba of a file, or are we still stuck with having to have
CAP_SYS_RAWIO in order to do that? This is something that all linux dvd
programs need to do in order to decrypt DVD, and it'd be nice if they
didn't all have to run as root. :)

Jason
