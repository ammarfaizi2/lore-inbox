Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVCWOAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVCWOAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVCWN6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:58:33 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:39440 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262552AbVCWN6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:58:03 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andrew Morton <akpm@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Samsung 40G drive locking up 2.6.11
Date: Wed, 23 Mar 2005 15:57:42 +0200
User-Agent: KMail/1.5.4
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
References: <200503221431.31549.vda@ilport.com.ua> <20050323023853.28c9a432.akpm@osdl.org>
In-Reply-To: <20050323023853.28c9a432.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503231557.42614.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 March 2005 12:38, Andrew Morton wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> >
> > dd if=/dev/hdc of=/dev/null with this disk
> >  kills the system. Drive may do it's work
> >  for minute or two, but then it does 'klak' sound.
> >  With udma5 (default) Linux froze solid, no SysRq key, nothing.
> >  Powercycling helps.
> > 
> >  With udma3, it did not die, but still spews IDE errors.
> >  I will try to collect more data points.
> 
> Did it work OK under earlier kernels?  If so, which?

I've tried only 2.6.11.

In spite seeing it going belly up at least four times,
taking the whole box with it, I cannot make this damned
drive fail anymore.

Seems to be one of those nasty intermittent hardware failures.
--
vda

