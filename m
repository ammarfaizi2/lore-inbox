Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272209AbRIEPyG>; Wed, 5 Sep 2001 11:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272214AbRIEPxq>; Wed, 5 Sep 2001 11:53:46 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:18705 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S272209AbRIEPxj>; Wed, 5 Sep 2001 11:53:39 -0400
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Michael Bacarella <mbac@nyct.net>, linux-kernel@vger.kernel.org
Subject: Re: getpeereid() for Linux
In-Reply-To: <200109051551.KAA48912@tomcat.admin.navo.hpc.mil>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 05 Sep 2001 17:53:22 +0200
In-Reply-To: <200109051551.KAA48912@tomcat.admin.navo.hpc.mil> (Jesse Pollard's message of "Wed, 5 Sep 2001 10:51:55 -0500 (CDT)")
Message-ID: <tgd755vdl9.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> writes:

> It is not possible to get a creditential from TCP connections yet. That
> requires an extension to IPSec to even be able to carry credentials. There
> is no reliable communication path (even for identd) to be able to pass
> credentials.

I need the credentials only for local connections, though.  This is
technically possible.  A userspace implementation partially cloning
ident seems to be a possible approach.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
