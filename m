Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbUKAXBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUKAXBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S380046AbUKAXAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:00:15 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:38564 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S274359AbUKAVtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:49:22 -0500
In-Reply-To: <BLEAIJDEHOOAGALIAAKBMEPCCCAA.pranav@nodeinfotech.com>
To: <pranav@nodeinfotech.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Subject: Re: Small Help required!!!
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF4B619707.EA6E09C8-ON88256F3F.007783E0-88256F3F.0077DEBE@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Mon, 1 Nov 2004 13:49:17 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.51HF338 | June 21, 2004) at
 11/01/2004 14:49:20,
	Serialize complete at 11/01/2004 14:49:20
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

netdev-bounce@oss.sgi.com wrote on 10/30/2004 08:32:55 AM:

> hi,
> I needed some information about how to proceed with implementing a Name
> Switch Server plugin that
> allows to resolve multicast DNS names using normal libc calls(such as
> gethostbyname()).

> If someone has knowledge in this regard,please mail me back.

I think this will already work as-is. All you should need to do is
register the multicast address in the DNS server.

Have you tried it? Some well-known multicast addresses (like NTP's) are
commonly registered with root servers already.

I haven't tried using "gethostbyame()" on a multicast address that is
registered, but I'm not aware of any checks on the class of the address
in any of the code.

                                        +-DLS

