Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262615AbREVKLA>; Tue, 22 May 2001 06:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbREVKKw>; Tue, 22 May 2001 06:10:52 -0400
Received: from mail.zmailer.org ([194.252.70.162]:51726 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S262605AbREVKKo>;
	Tue, 22 May 2001 06:10:44 -0400
Date: Tue, 22 May 2001 13:10:31 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-ppp@vger.kernel.org
Subject: ECN is on!
Message-ID: <20010522131031.C5947@mea-ext.zmailer.org>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and immediately I have been able to verify a bunch of
domains/servers which won't get thru when incoming connection
has ECN.    I tested all of these with Linux running ECN, and
Solaris 2.6 without ECN.  When Solaris got connection, and
ECN-Linux didn't, domain and its server got listed.

Amazing share of these troubled destination systems run some
firewall which thinks it is cool to fuck SMTP protocol.
(I mean obscuring responses given by the remote system,
 frobbing incoming protocol if some particular detail doesn't
 please the rules it presumes to play with, etc..)

I am contemplating to periodically turn off the ECN bit to
let email out, but DaveM has veto there.

This list is NOT exhaustive of domains with problems, it
primarily lists only those who are subscribers of linux-kernel,
and thus accumulated (al lot) more than 1 email with "connection
timed out" status into vger's queue.


  DEST. DOMAIN                     SERVER NAME

ic.sunysb.edu                   -> bartman.ic.sunysb.edu
olympus.phys.wesleyan.edu       -> olympus.phys.wesleyan.edu
imap.reed.edu                   -> imogen.reed.edu
aplcomm.jhuapl.edu              -> dallas.jhuapl.edu
mail.utexas.edu                 -> mx2.mail.utexas.edu
cs.jhu.edu                      -> hops.cs.jhu.edu
judy.indstate.edu       - gets connected, but then freezes.
cc.usu.edu                      -> cc.usu.edu
aubi.de                         -> mail.aubi-online.de
opensource.se                   -> mail.carambole.com
routemeister.net		-> mail.carambole.com
*.swipnet.se                    -> smtp-ext.swip.net
swipnet.se                      -> smtp-ext.swip.net
get2net.dk			-> smtp-ext.swip.net
dina.kvl.dk			-> sheridan.dina.kvl.dk
enea.se				-> ruff.enea.se
able.es				-> jalon.able.es
vadoc.state.va.us		-> mail.vadoc.state.va.us
libero.it			-> smtp-in.libero.it
ra.cit.alcatel.fr		-> mail.alcatel.fr
csse.monash.edu.au		-> ld-mx.it.monash.edu.au
galactica.it			-> mail.galactica.it
ds.catv.ne.jp			-> cs14.catv.ne.jp
mailbox.dsnet.it		-> mailin.dsnet.it
lee.k12.nc.us			-> shomer.lee.k12.nc.us
sh.bel.alcatel.be		-> mx001.alcatel.be
quantum.cicese.mx		-> quantum.cicese.mx
isuzu.pl			-> isztye02.isuzu.pl
gruppocredit.it			-> mext.gruppocredit.it
debitel.net			-> mail.dnsg.net
optical.lvl.pri.bms.com		-> chimera.bms.com
us.celoxica.com			-> mail.us.embeddedsol.com
ford.com			-> mail0.allegro.net
vnnews.com			-> mail.cinet.vnn.vn
echostar.com			-> rf-mail1.echostar.com
jetform.com			-> mail.jetform.com
half.com			-> mailhub.half.com
pa.dec.com			-> ztxmail01.ztx.compaq.com
compaq.com			-> ztxmail01.ztx.compaq.com
zk3.dec.com			-> ztxmail01.ztx.compaq.com
allaire.com			-> smtp.allaire.com
catalog-international.com	-> ciexchange.catalog-international.com
lcr-m.com			-> mail1.lcr-m.net
logica.com			-> mail4.messagelabs.com
missioncriticallinux.com	-> mail.missioncriticallinux.com
msdw.com			-> mx1.ms.com
honeywell.com			-> tmpsmtp702.honeywell.com
austin.ibm.com			-> mg02.austin.ibm.com
btinternet.com			-> moongate.btinternet.com
geeksimplex.org			-> DNS A: 24.18.90.197 (home.com cable)
