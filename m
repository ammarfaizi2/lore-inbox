Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTDJMjo (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 08:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbTDJMjo (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 08:39:44 -0400
Received: from mail.ithnet.com ([217.64.64.8]:19974 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264030AbTDJMjn (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 08:39:43 -0400
Date: Thu, 10 Apr 2003 13:20:55 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: alan@lxorguk.ukuu.org.uk, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges
Message-Id: <20030410132055.1745749c.skraw@ithnet.com>
In-Reply-To: <194120000.1049909641@aslan.btc.adaptec.com>
References: <200304082124_MC3-1-3399-FBD0@compuserve.com>
	<1049886804.9901.19.camel@dhcp22.swansea.linux.org.uk>
	<194120000.1049909641@aslan.btc.adaptec.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Apr 2003 11:34:01 -0600
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> > On Mer, 2003-04-09 at 02:21, Chuck Ebbert wrote:
> >> And your code goes for long periods of time without merging good fixes,
> >> like this one (from 2.4.20):
> > 
> > Which is one reason Justin's patches don't get merged. They are giant
> > changes which back out other clear corrections.
> 
> This tells me two things:
> 
> 1) You don't trust maintainers.  If a maintainer can't make large changes,
>    who can?
> 
> 2) When a maintainer makes a mistake (fails to integrate a good change,
>    or introduces a bug), the maintainers changes are simply dropped rather
>    then notify (either politely or not I don't much care) the maintainer
>    of his/her mistake.
> 
> Neither of the above applied to integration of the aic79xx driver into
> the 2.4.X tree, but it still took something like 8 months.
> 
> There must be a better way.

As I am probably one of the victims of these differing opinions, can anyone
tell me where to get a really-known-to-work aic-driver for 2.4? I am
experiencing zapping-black events while reading from a SDLT drive (writing to
it does fine).

Short hardware story:
02:03.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:03.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: IC35L073UWDY10-0 Rev: S21E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: SDLT320          Rev: 3838
  Type:   Sequential-Access                ANSI SCSI revision: 02

Any hints welcome

Regards,
Stephan

