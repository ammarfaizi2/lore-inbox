Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXKvD>; Wed, 24 Jan 2001 05:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRAXKuy>; Wed, 24 Jan 2001 05:50:54 -0500
Received: from mail.zmailer.org ([194.252.70.162]:4360 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129401AbRAXKul>;
	Wed, 24 Jan 2001 05:50:41 -0500
Date: Wed, 24 Jan 2001 12:50:31 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: What that Majordomo testing was about ...
Message-ID: <20010124125031.W25659@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="livrSZtJkVq9DDdS"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--livrSZtJkVq9DDdS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, I think I have waited enough to be fairly sure that
now the thing worked.


The first goal was to create configuration which detects
the presense of:
   X-Mailing-List: linux-kernel@vger.kernel.org
header, and blocks it.
That should prevent loops in the list when somebody
goofs up and sends email out from their fetchmail, or
whatever, to the VISIBLE headers of the message.

Tabooing some discussion subjects isn't primary goal, but
apparently such is also possible, if needed.

Also tabooing messages which contain juicy key phrases
which spammers often use to "legitimize" their postings
is possible, although presently not very much such spam
email makes to the system (and thus thru the lists).
It is amazing what RBL+DUL+RSS trio can filter quickly.

... and none of that discussion above should make to the list
under subject of "Third Majordomo Test" ;)

/Matti Aarnio

--livrSZtJkVq9DDdS
Content-Type: message/rfc822
Content-Disposition: inline

Received: (from localhost user: 'mea' uid#500 fake: STDIN (mea@zmailer.org))
	by mail.zmailer.org id <S2622111AbRAXKjc>;
	Wed, 24 Jan 2001 12:39:32 +0200
Date: Wed, 24 Jan 2001 12:39:32 +0200
Sender: Matti Aarnio <mea@zmailer.org>
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Third Majordomo taboo_header test
Message-ID: <20010124123932.V25659@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: <mea@zmailer.org>
X-Envelope-To: <mea@zmailer.org> (uid 500)
X-Orcpt: rfc822;mea@mea-ext.zmailer.org

The first goal is to create configuration which detects
the presense of:
   X-Mailing-List: linux-kernel@vger.kernel.org
header, and blocks it.
That should prevent loops in the list when somebody
goofs up and sends email out from their fetchmail, or
whatever, to the VISIBLE headers of the message.

Tabooing some discussion subjects isn't primary goal, but
apparently such is also possible, if needed.

... and none of that discussion should make to the list ;)

/Matti Aarnio

--livrSZtJkVq9DDdS--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
