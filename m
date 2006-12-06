Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937718AbWLFWF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937718AbWLFWF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937716AbWLFWF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:05:56 -0500
Received: from styx.suse.cz ([82.119.242.94]:39117 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937712AbWLFWFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:05:55 -0500
Date: Wed, 6 Dec 2006 23:05:46 +0100
From: Jiri Benc <jbenc@suse.cz>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Ivo van Doorn" <ivdoorn@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, "John Linville" <linville@tuxdriver.com>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless
 radio
Message-ID: <20061206230546.41519771@logostar.upir.cz>
In-Reply-To: <d120d5000612061218x4eac87e0jc18409f82bb7c99c@mail.gmail.com>
References: <200612031936.34343.IvDoorn@gmail.com>
	<200612050027.15253.IvDoorn@gmail.com>
	<d120d5000612060637s69ff235fo85a2db923a728a00@mail.gmail.com>
	<200612062031.57148.IvDoorn@gmail.com>
	<d120d5000612061218x4eac87e0jc18409f82bb7c99c@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 15:18:12 -0500, Dmitry Torokhov wrote:
> On 12/6/06, Ivo van Doorn <ivdoorn@gmail.com> wrote:
> > Ok, so input device opening should not block the rfkill signal and the rfkill handler
> > should still go through with its work unless a different config option indicates that
> > userspace wants to handle the event.
> 
> I don't think a config option is a good idea unless by config option
> you mean a sysfs attribute.

What about using EVIOCGRAB ioctl for this?

 Jiri

-- 
Jiri Benc
SUSE Labs
