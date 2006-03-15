Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWCONgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWCONgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWCONgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:36:32 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:55531 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751252AbWCONgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:36:31 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: /dev/stderr gets unlinked 8]
Date: Wed, 15 Mar 2006 15:34:41 +0200
User-Agent: KMail/1.8.2
Cc: Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       christiand59@web.de
References: <200603141213.00077.vda@ilport.com.ua> <20060315110252.GB31317@suse.de> <jehd5zq28o.fsf@sykes.suse.de>
In-Reply-To: <jehd5zq28o.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603151534.41899.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 15:14, Andreas Schwab wrote:
> Stefan Seyfried <seife@suse.de> writes:
> 
> > any good daemon closes stdout, stderr, stdin
> 
> A real good daemon would redirect them to /dev/null.

Yeah, yeah, let's first close stderr, and then proceed and 
add some code to handle command line --log=file, and to do
logging to that file.

Why good ol' fprintf(stderr,...) isn't enough? Why do you
want to complicate things?

What's so hard in doing "daemon 2>/dev/null &" if you don't
want to save log?
--
vda
