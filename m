Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRDBSXl>; Mon, 2 Apr 2001 14:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbRDBSXc>; Mon, 2 Apr 2001 14:23:32 -0400
Received: from fo.lugos.si ([212.93.228.69]:25907 "HELO fo.lugos.si")
	by vger.kernel.org with SMTP id <S131290AbRDBSXR>;
	Mon, 2 Apr 2001 14:23:17 -0400
To: linux-kernel@vger.kernel.org
From: sympa-request@lugos.si
Subject: User guide
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010402182109.67E027C86@fo.lugos.si>
Date: Mon,  2 Apr 2001 20:21:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


              SYMPA -- Systeme de Multi-Postage Automatique
                       (Automatic Mailing System)

                                User's Guide


SYMPA is an electronic mailing-list manager that automates list management
functions such as subscriptions, moderation, and archive management.

All commands must be sent to the electronic address 

You can put multiple commands in a message. These commands must appear in the
message body and each line must contain only one command. The message body
is ignored if the Content-Type is different from text/plain but even with
crasy mailer using multipart and text/html for any message, commands in the
subject are recognized.

Available commands are:

 HELp                        * This help file
 INFO                        * Information about a list
 LISts                       * Directory of lists managed on this node
 REView <list>               * Displays the subscribers to <list>
 WHICH                       * Displays which lists you are subscribed to
 SUBscribe <list> <GECOS>    * To subscribe or to confirm a subscription to
                               <list>, <GECOS> is an optional information
                               about subscriber.

 UNSubscribe <list> <EMAIL>  * To quit <list>. <EMAIL> is an optional 
                               email address, usefull if different from
                               your "From:" address.
 UNSubscribe * <EMAIL>       * To quit all lists.

 SET <list|*> NOMAIL         * To suspend the message reception for <list>
 SET <list|*> DIGEST         * Message reception in compilation mode
 SET <list|*> SUMMARY        * Receiving the message index only
 SET <list|*> MAIL           * <list> reception in normal mode
 SET <list|*> CONCEAL        * To become unlisted (hidden subscriber address)
 SET <list|*> NOCONCEAL      * Subscriber address visible via REView


 INDex <list>                * <list> archive file list
 GET <list> <file>           * To get <file> of <list> archive
 LAST <list>                 * Used to received the last message from <list>
 INVITE <list> <email>       * Invite <email> for subscribtion in <list>
 CONFIRM <key>               * Confirmation for sending a message (depending
                               on the list's configuration)
 QUIT                        * Indicates the end of the commands (to ignore a
                               signature)


Powered by Sympa 3.0.3 : http://listes.cru.fr/sympa/

