Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUCGKtW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 05:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbUCGKtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 05:49:22 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:14599 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261806AbUCGKtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 05:49:19 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: server migration
Date: Sun, 7 Mar 2004 12:31:50 +0200
User-Agent: KMail/1.5.4
References: <20040305181322.GA32114@the-penguin.otak.com> <200403070133.07784.vda@port.imtp.ilyichevsk.odessa.ua> <20040307013507.GB13908@the-penguin.otak.com>
In-Reply-To: <20040307013507.GB13908@the-penguin.otak.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403071231.50912.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 March 2004 03:35, Lawrence Walton wrote:
> Denis Vlasenko [vda@port.imtp.ilyichevsk.odessa.ua] wrote:
> > On Friday 05 March 2004 20:13, Lawrence Walton wrote:
> > > Hi all!
> > >
> > > I tried about four months ago to migrate a busy server to 2.6.0-test9,
> > > and failed miserably. Lightly loaded it worked well but as the number
> > > of users increased, the number of processes in uninterruptible sleep
> > > increased to the hundreds and then the server fell on it's face. I
> > > never found out exactly why or what processes where hanging if I
> > > guessed it would be openldap.
> >
> > Why do you guess? Determine what processes are stuck.
>
> Because I did not expect it to happen, I had lots of users screaming at
> me to fix it now, when it did happen. The server had been up sense the
> night before. It was not until users started showing up in the morning
> that the problem manifested itself.
>
> The point is I was hoping to get a list of things to try to capture in
> case it happened again, testing is all well and good, but getting
> information from a production box can be valuable, as long as it's not
> some odd corner case.
>
> Capturing SysRq-T was on my list to do.
> I'll investigate stack pointers, and If I can post stack traces.

Well. That's easy. Just press SysRq-T and look into syslog.
--
vda

