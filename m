Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143401AbREKVGl>; Fri, 11 May 2001 17:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143400AbREKVGb>; Fri, 11 May 2001 17:06:31 -0400
Received: from oss.sgi.com ([216.32.174.190]:59148 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S143399AbREKVGR>;
	Fri, 11 May 2001 17:06:17 -0400
Date: Fri, 11 May 2001 12:11:46 -0300
From: Ralf Baechle <ralf@uni-koblenz.de>
To: mirabilos <eccesys@topmail.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth
Message-ID: <20010511121146.A3224@bacchus.dhis.org>
In-Reply-To: <00da01c0d251$240894e0$de00a8c0@homeip.net> <20010501175312.A1057@werewolf.able.es> <001e01c0d2eb$2cc17f80$de00a8c0@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001e01c0d2eb$2cc17f80$de00a8c0@homeip.net>; from eccesys@topmail.de on Wed, May 02, 2001 at 09:35:05AM -0000
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 09:35:05AM -0000, mirabilos wrote:

> > What you have todo is to learn how to configure your mailer to display
> > headers you want.
> 
> Not the displaying annoys me, it's the traffic. The headers usually are
> less than multiple quoted sigs, though.

Headers serve a technical purpose.  So for example adding Received: headers
is a MUST according to RFC 2822, 3.8.2:

3.8.2 Received Lines in Gatewaying

   When forwarding a message into or out of the Internet environment, a
   gateway MUST prepend a Received: line, but it MUST NOT alter in any
   way a Received: line that is already in the header.

Similar for the other headers; basically all of them cannot be removed
without loosing functionality or putting the reliability of the mail
system at stake.  Let me just say mail loops ...

  Ralf
