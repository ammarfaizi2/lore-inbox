Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270174AbRIMMWI>; Thu, 13 Sep 2001 08:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270229AbRIMMVt>; Thu, 13 Sep 2001 08:21:49 -0400
Received: from mail.zmailer.org ([194.252.70.162]:64264 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S270174AbRIMMV2>;
	Thu, 13 Sep 2001 08:21:28 -0400
Date: Thu, 13 Sep 2001 15:21:19 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: csaradap <csaradap@mihy.mot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: junk values at ppplogin
Message-ID: <20010913152119.V11046@mea-ext.zmailer.org>
In-Reply-To: <3BA0A0D0.19E0E76F@mihy.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BA0A0D0.19E0E76F@mihy.mot.com>; from csaradap@mihy.mot.com on Thu, Sep 13, 2001 at 05:34:32PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 (sourceforge list removed from reply, those are usually
  'posting by members only', thus it makes no sense for
  me even to try to post to them.)

On Thu, Sep 13, 2001 at 05:34:32PM +0530, csaradap wrote:
> I am configuring a ppp link over null modem. When I am trying to login I
> get junk values like

  Junk ?   That is PPP protocol being spoken on the line, although
most of the "control" characters sent over there you won't see (and
thus have incorrectly pasted them).

If you want to have a normal text-login, there needs to be e.g. a 'getty'
program at that serial line.  Now you have something else.
(There are several different programs that behave like the original
 'getty', usually their name contains 'getty' string.)

Reading more of PPP FAQs and HOWTOs will tell you what you will need to
setup at the serial ports of both machines.   In essence you setup
network connection between the machines, then you use some network
protocol to communicate in between the machines.  NOT serial terminal!


> ~ÿ}#À!}!}!} }4}"}&} } } } }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } } }%}&*}]ÝH}'}"}(}"ÉÂ~
> 
> Can any body tell me what is the problem???
> thanx
> cspn

/Matti Aarnio
