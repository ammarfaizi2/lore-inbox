Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSHTH2e>; Tue, 20 Aug 2002 03:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSHTH2e>; Tue, 20 Aug 2002 03:28:34 -0400
Received: from mail.zmailer.org ([62.240.94.4]:21185 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S315449AbSHTH2d>;
	Tue, 20 Aug 2002 03:28:33 -0400
Date: Tue, 20 Aug 2002 10:32:36 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Venkat Raghu <venkatraghu2002@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: newbie
Message-ID: <20020820073236.GB32427@mea-ext.zmailer.org>
References: <20020819223018.79961.qmail@web40015.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020819223018.79961.qmail@web40015.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 03:30:18PM -0700, Venkat Raghu wrote:
> Hi,
> 
> I have a bash script which modifies some environment
> variables and does some other housekeeping things.
> But problem is that when script finishes running,
> new values of environment variables are no longer
> visible in parent shell. So what should I do so that
> these new values are visible in parent. I don't want
> to run as ". file.sh". I have to run it as "file.sh"
> only.

  The things you do in child process environments are
  inheritable only to their childs, never to parent.
  If they were, there would be massive security problems,
  just to mention one consequence...

  If you want your current shell to get the new values,
  you have to do:  . file.sh

> Kindly mail me at venkatraghu2002@yahoo.com
> 
> Regards
> Venkat.
