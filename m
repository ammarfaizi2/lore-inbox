Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTDYEMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 00:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTDYEMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 00:12:12 -0400
Received: from nef.ens.fr ([129.199.96.32]:55313 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S262912AbTDYEMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 00:12:08 -0400
Date: Fri, 25 Apr 2003 06:24:12 +0200
From: David Madore <david.madore@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: interrupting connect(), EINTR, EINPROGRESS, EALREADY, and so on
Message-ID: <20030425062412.A13355@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I hope this is not too off-topic for this list.  I have discovered
discrepancies between various Unix implementations and/or their
documentation, and the Single Unix Specification, concerning the
behavior of the connect() system call for blocking, stream, sockets,
when it is interrupted by a signal.  Rather than explain it all, I'll
refer you to the Web page I just wrote about this, namely <URL:
http://www.eleves.ens.fr:8080/home/madore/computers/connect-intr.html
>.

I believe that the behavior Linux uses is the best, but it seems to be
at odds with a literal reading of the Specification.  (Details and
explanations are on the page I've just mentioned.)  I'd like to know a
little more about this, e.g., how it was decided and by whom, and
when, and what arguments can be given to support it.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
