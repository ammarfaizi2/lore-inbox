Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSIFPuG>; Fri, 6 Sep 2002 11:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSIFPuF>; Fri, 6 Sep 2002 11:50:05 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:24565
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319223AbSIFPsg>; Fri, 6 Sep 2002 11:48:36 -0400
Subject: Re: VIA82cxxx sound problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordanc@censoft.com>
Cc: Theewara Vorakosit <g4465018@pirun.ku.ac.th>, linux-kernel@vger.kernel.org
In-Reply-To: <20020906092705.7a746d39.jordanc@censoft.com>
References: <Pine.GSO.4.44.0209061822580.1094-100000@pirun.ku.ac.th> 
	<20020906092705.7a746d39.jordanc@censoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 16:53:15 +0100
Message-Id: <1031327595.9945.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 16:27, Jordan Crouse wrote:
> > Dear All,
> > 	I use Gigabyte GA-7VTXE+, equip with on board sound card. When I
> > use sound card (when start KDE), there is a lot of message:
> > 
> > via82cxxx warning: SG stopped or paused
> > 
> > I'm using kernel 2.4.18-3, Red Hat 7.3. Would you please tell me how to solve this problem?
> 
> You motherboard has a VA8233A south bridge, which is more fully supported in 2.4.19 than in the Red Hat kernel.  Upgrade, and your problems should go away (or at least, get easier to debug).

Actually the audio hasnt changed between the Red Hat tree and that one.
There is very little via audio support in Linux. Running the vanilla
2.4.19 versus RH 2.4.18-3 isnt going to help and is going to introduce
all the bugs Red Hat fixed that are still working there way in post
2.4.19


