Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWAINf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWAINf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWAINfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:35:25 -0500
Received: from terrhq.ru ([81.222.97.18]:51848 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S1751465AbWAINfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:35:08 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: CaT <cat@zip.com.au>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Mon, 9 Jan 2006 16:34:51 +0300
User-Agent: KMail/1.9
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <200601091403.46304.yarick@it-territory.ru> <20060109124545.GA2035@zip.com.au>
In-Reply-To: <20060109124545.GA2035@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091634.52107.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
On 9 January 2006 15:45, CaT wrote:
> On Mon, Jan 09, 2006 at 02:03:46PM +0300, Yaroslav Rastrigin wrote:
> > Suspend to disk has nasty tendency to ruin my whole hot live X session, since X can't properly restore VT on resume.
> 
> Not necessarily a solution but have you thought of putting chvt in the
> suspend/resume sequence? chvt to a terminal before suspending and chvt
> to X after resume.
Yes, of course. I've spent countless hours trying to figure solution for this particular problem. Tried generic Linux suspend-to-disk and swsusp2, 
changing terminals before/after suspend, delay sleeps, vbetool and all that fuss and jazz. Looks like race condition somewhere between kernel and X driver.
> 
> Still, the above might help you until you find someone to throw money
> at. ;)
Ahhh. Sweet dream - to be able to offer money to fix extremely annoying bugs or to add missing features. 
Unfortunately, bounties doesn't work :-/ 
> 

-- 
Managing your Territory since the dawn of times ...
